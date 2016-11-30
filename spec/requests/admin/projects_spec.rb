require "rails_helper"

describe "Admin::ProjectController" do
  let(:user) { create :user }

  describe "GET /admin/projects", :vcr, type: :request do
    it "denies access when logged out" do
      get admin_projects_path
      expect(response).to redirect_to(login_path)
    end

    it "denies access for non-admins" do
      login(user)
      expect { visit admin_projects_path }.to raise_exception ActiveRecord::RecordNotFound
    end

    it "renders successfully for admins" do
      mock_is_admin
      login(user)
      visit admin_projects_path
      expect(page).to have_content 'Popular projects without repo links'
    end
  end

  describe "GET /admin/projects/deprecated", :vcr, type: :request do
    it "denies access when logged out" do
      get deprecated_admin_projects_path
      expect(response).to redirect_to(login_path)
    end

    it "denies access for non-admins" do
      login(user)
      expect { visit deprecated_admin_projects_path }.to raise_exception ActiveRecord::RecordNotFound
    end

    it "renders successfully for admins" do
      mock_is_admin
      login(user)
      visit deprecated_admin_projects_path
      expect(page).to have_content 'Deprecated projects'
    end
  end

  describe "GET /admin/projects/unmaintained", :vcr, type: :request do
    it "denies access when logged out" do
      get unmaintained_admin_projects_path
      expect(response).to redirect_to(login_path)
    end

    it "denies access for non-admins" do
      login(user)
      expect { visit unmaintained_admin_projects_path }.to raise_exception ActiveRecord::RecordNotFound
    end

    it "renders successfully for admins" do
      mock_is_admin
      login(user)
      visit unmaintained_admin_projects_path
      expect(page).to have_content 'Unmaintained projects'
    end
  end

  describe "GET /admin/projects/:id", :vcr, type: :request do
    let(:project) { create(:project) }

    it "denies access when logged out" do
      get admin_project_path(project.id)
      expect(response).to redirect_to(login_path)
    end

    it "denies access for non-admins" do
      login(user)
      expect { visit admin_project_path(project.id) }.to raise_exception ActiveRecord::RecordNotFound
    end

    it "renders successfully for admins" do
      mock_is_admin
      login(user)
      visit admin_project_path(project.id)
      expect(page).to have_content project.name
    end
  end
end
