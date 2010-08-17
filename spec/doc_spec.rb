require 'spec_helper'

describe Doculab::Doc do
  describe "class" do
    it "knows where to find the documentation files" do
      Doculab::Doc.directory.should == Rails.root.join('doculab', 'docs')
    end
  end
  
  describe "#find" do
    it "returns a new Doc when passed a good permalink" do
      doc = Doculab::Doc.find(good_permalink)
      doc.should be_a(Doculab::Doc)
    end
    
    it "raises a Doculab::Doc::FileNotFound exception for a bad permalink" do
      lambda { Doculab::Doc.find(bad_permalink) }.should raise_error(Doculab::Doc::FileNotFound)
    end
    
    it "raises a Doculab::Doc::FileNotFound exception for an empty permalink" do
      lambda { Doculab::Doc.find('') }.should raise_error(Doculab::Doc::FileNotFound)
    end

    it "raises a Doculab::Doc::FileNotFound exception for a nil permalink" do
      lambda { Doculab::Doc.find(nil) }.should raise_error(Doculab::Doc::FileNotFound)
    end
  end
  
  describe "instance created from Doculab::Doc.find" do
    before(:each) do
      @doc = Doculab::Doc.find(good_permalink)
      @filepath = Doculab::Doc.directory.join("#{good_permalink}.textile").to_s
    end
    
    it "stores its permalink" do
      @doc.permalink.should == good_permalink
    end
    
    it "stores its filesystem file" do
      @doc.file.should == @filepath
    end
    
    it "stores its content" do
      @doc.content.should == File.read(@filepath)
    end
  end
end
