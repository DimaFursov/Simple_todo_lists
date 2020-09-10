class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @projects = current_user.projects
      @project = current_user.projects.new
      #@project = current_user.projects.build
      #<Project:0x007f2a8efa1760 id: nil, name: nil, user_id: 1, created_at: nil, updated_at: nil>.any?
      @list_itemsprojects = current_user.listprojects # Project.where("user_id = ?", id)
      #@projects = current_user.projects # nil class="project_form" id="project-NIL"
        
      #@project_count = current_user.projects.count
      @date = Time.now
    end  
  end
end
=begin
[1] pry(#<#<Class:0x007ff3c3088d60>>)> @projects
  Project Load (0.1ms)  SELECT "projects".* FROM "projects" WHERE "projects"."user_id" = ?  ORDER BY "projects"."created_at" DESC  [["user_id", 1]]
=> [#<Project:0x007ff3b433a860 id: nil, name: nil, user_id: 1, created_at: nil, updated_at: nil>]
# nil class="project_form" id="project-NIL"


  [1] pry(#<#<Class:0x007ff3b83d6bd0>>)> @feed_itemsprojects
  Project Load (0.2ms)  SELECT "projects".* FROM "projects" WHERE (user_id = 1)  ORDER BY "projects"."created_at" DESC
=> []
[2] pry(#<#<Class:0x007ff3b83d6bd0>>)> 
   (0.3ms)  SELECT COUNT(*) FROM "projects" WHERE "projects"."user_id" = ?  [["user_id", 1]]
  Rendered shared/_listprojects.html.erb (3.4ms)
  Rendered static_pages/home.html.erb within layouts/application (197777.2ms)
Completed 500 Internal Server Error in 197783ms (ActiveRecord: 0.7ms)

ArgumentError ('nil' is not an ActiveModel-compatible object. It must implement :to_partial_path.):
  app/views/shared/_listprojects.html.erb:9:in `_app_views_shared__listprojects_html_erb__3406627487579479017_70342405953720'
  app/views/static_pages/home.html.erb:25:in `_app_views_static_pages_home_html_erb__4543623312712706808_70342348692720'


  Rendered /home/nomid/.rvm/gems/ruby-2.3.3/gems/web-console-2.0.0.beta3/lib/action_dispatch/templates/rescues/_source.erb (7.4ms)
  Rendered /home/nomid/.rvm/gems/ruby-2.3.3/gems/web-console-2.0.0.beta3/lib/action_dispatch/templates/rescues/_trace.html.erb (3.1ms)
  Rendered /home/nomid/.rvm/gems/ruby-2.3.3/gems/web-console-2.0.0.beta3/lib/action_dispatch/templates/rescues/_request_and_response.html.erb (1.0ms)
  Rendered /home/nomid/.rvm/gems/ruby-2.3.3/gems/web-console-2.0.0.beta3/lib/action_dispatch/templates/rescues/_web_console.html.erb (0.8ms)
  Rendered /home/nomid/.rvm/gems/ruby-2.3.3/gems/web-console-2.0.0.beta3/lib/action_dispatch/templates/rescues/diagnostics.html.erb within rescues/layout (27.6ms)




  [1] pry(#<#<Class:0x007ff3c0c16298>>)> @feed_itemsprojects
  Project Load (0.2ms)  SELECT "projects".* FROM "projects" WHERE (user_id = 1)  ORDER BY "projects"."created_at" DESC
  => [#<Project:0x007ff3b5d0ce78
  id: 2,
  name: "QWEqwe123",
  user_id: 1,
  created_at: Thu, 10 Sep 2020 15:03:17 UTC +00:00,
  updated_at: Thu, 10 Sep 2020 15:03:17 UTC +00:00>]

=end