# Query the cache directly.
# Use a redis or memcached backend.
  def attendance(params)
    Rails.cache.fetch({attendance_calc: 1}.merge(params))  do
      # magic happens here, using params to calulate attendance, and return that value
    
    end
  end


# Make sure that the _form partial for register is multipart to allow image uploads.

# Deployment Procedure:

After:
# 1) The custom entry form can preview, add, and update register_images paperclip images,
2) The activeadmin views can display and manage paperclip images,
# 3) You've configured a thumbnail style for a preview,
# DONE 4) Configured paperclip to use s3 storage via config/initializer/paperclip.rb (look at annotation studio config)
5) Fixed views that render content to use paperclip paths
6) Fixed code to use the simplified method of figuring out if an image is recto or verso via something like 

class Register
  def recto_image
    register_images.find(orientation: 'recto')
  end
end

Then you can run the migration rake task (filepath:migrate_to_paperclip) on heroku.

Once you've confirmed that you've successfully migrated to paperclip, then:
* Create a migration to remove the legacy "filepath" attribute from RegisterImages

TBD: Figure out a way to fix the flipbook links.
