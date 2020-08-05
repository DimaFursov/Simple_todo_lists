require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @project = @user.projects.build(name: "Lorem ipsum")
  end  
  # test "the truth" do
  #   assert true
  # end
end
