require "spec_helper"

describe UserMailer do
  describe "todon" do
    let(:mail) { UserMailer.todon }

    it "renders the headers" do
      mail.subject.should eq("test")
      mail.to.should eq(["dondenoncourt@gmail.com"])
      mail.from.should eq("no-reply@theshoplift.com")
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
