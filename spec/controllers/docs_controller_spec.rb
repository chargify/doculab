require 'spec_helper'

describe Doculab::DocsController do
  describe "layout selection" do
    before(:each) do
      reset_layouts!
    end
    
    after(:each) do
      reset_layouts!
    end

    context "with the default layouts" do
      it "uses the 'docs' layout for the index page" do
        get :index
        controller.send(:_layout).should == 'docs'
      end
      
      it "uses the 'docs' layout for a doc page" do
        get :show, :permalink => good_permalink
        controller.send(:_layout).should == 'docs'
      end
    end
    
    context "with a custom main_layout" do
      before(:each) do
        Doculab.main_layout = 'custom'
      end
      
      it "uses the 'custom' layout for the index page" do
        get :index
        controller.send(:_layout).should == 'custom'
      end
      
      it "uses the 'custom' layout for a doc page" do
        get :show, :permalink => good_permalink
        controller.send(:_layout).should == 'custom'
      end
    end

    context "with a custom index_layout" do
      before(:each) do
        Doculab.index_layout = 'custom'
      end
      
      it "uses the 'custom' layout for the index page" do
        get :index
        controller.send(:_layout).should == 'custom'
      end
      
      it "uses the 'docs' layout for a doc page" do
        get :show, :permalink => good_permalink
        controller.send(:_layout).should == 'docs'
      end
    end
    
    def reset_layouts!
      Doculab.main_layout = nil
      Doculab.index_layout = nil
    end
  end
end
