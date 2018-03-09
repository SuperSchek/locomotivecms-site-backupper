require 'locomotive/coal'
require 'dotenv'

Dotenv.load

# Init client
client = Locomotive::Coal::Client.new(ENV['ENGINE_URL'], { email: ENV['ENGINE_EMAIL'], api_key: ENV['ENGINE_API_KEY'] })

# Get all my sites
my_sites = client.sites.all

# Create status_report string
status_report = 'The following sites were backed up: \n\n'

# # Loop over sites on Engine
my_sites.each do |site|
  if (system 'wagon backup ' + site.handle + ' ' + ENV['ENGINE_URL'] + ' -h ' + site.handle + ' -e ' + ENV['ENGINE_EMAIL'] + ' -a ' + ENV['ENGINE_API_KEY'] + ' -v >&2')

    # Move backup files to another folder if FILE_DEST varibale has been set in .env
    if (ENV['FILE_DEST'])
      puts `sudo mv #{site.handle}/ #{ENV['FILE_DEST']}#{site.handle}/`
    end

    # Appends success to status_report
    status_report.concat(site.name + ': OK\n')
  else
    # Appends failure to status_report
    status_report.concat(site.name + ': FAIL\n')
  end
end

# Send pushbullet notification if PUSHBULLET_ACCES_TOKEN is set in .env
if (ENV['PUSHBULLET_ACCES_TOKEN'])
  puts `curl --header 'Access-Token: #{ENV['PUSHBULLET_ACCES_TOKEN']}' \
       --header 'Content-Type: application/json' \
       --data-binary '{"body":"#{status_report}","title":"LocomotiveCMS sites are backed up!","type":"note"}' \
       --request POST \
       https://api.pushbullet.com/v2/pushes`
end
