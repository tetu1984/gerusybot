require 'spec_helper'

describe "welcome/index.html.erb" do
  before do
    render
  end
  it "display a message" do
    expect(rendered).to include('Coffee please.')
  end
end
