require 'spec_helper'

describe Doculab do
  it "defines Doculab::Doc" do
    Doculab::Doc.is_a?(Class)
  end
end