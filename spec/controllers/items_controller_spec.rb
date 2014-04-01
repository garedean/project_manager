require 'rails_helper'

RSpec.describe ItemsController, :type => :controller do
  let(:project) { Project.create!(:title => 'A Project') }

  describe "GET new" do
    before do
      get :new, :project_id => project.id
    end

    it "assigns project" do
      expect(assigns(:project)).to eq(project)
    end

    it "assigns new item" do
      expect(assigns(:item)).to be_a_new(Item)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before do
        post :create, { :project_id => project.id,
                        :item => { :action => "Retrieve money." } }
      end

      it 'creates a new item' do
        expect(project.reload.items.count).to eq(1)
      end

      it 'sets notice' do
        expect(flash[:notice]).to eq('Item was successfully created.')
      end

      it 'redirects to project page' do
        expect(response).to redirect_to(project_path(project))
      end
    end
  end

  describe "GET edit" do
    let(:item) { project.items.create(:action => 'Go shopping.') }
    before do
      get :edit, :project_id => project.id, :id => item.id
    end

    it 'assigns project' do
      expect(assigns(:project)).to eq(project)
    end

    it 'assigns item' do
      expect(assigns(:item)).to eq(item)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:item) {
        project = Project.create!(:title => 'A Project')
        project.items.create!(:action => 'thing to do')
      }
      before do
        put :update, { :id => item.id, :project_id => item.project.id,
                       :item => { :action => "bar" } }
      end

      it 'updates the requested item' do
        expect(Item.first.action).to eq('bar')
      end

      it 'assigns requested item' do
        expect(assigns(:item)).to eq(item)
      end

      it 'redirects to the project page' do
        expect(response).to redirect_to(project_path(item.project))
      end
    end
  end
end
