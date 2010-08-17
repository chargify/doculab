Given /^there is a valid doc file$/ do
  if filename = first_existing_doc_filename
    permalink = filename.split(".").first
  else
    permalink = nil
  end
  @doc = Doculab::Doc.find(permalink)
end

Then /^I should see the doc content$/ do
  Then %{I should see "#{@doc.content}"}
end

def first_existing_doc_filename
  Doculab::Doc.filenames.first
end