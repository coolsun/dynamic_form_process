require 'test_helper'

class StanfordMailerTest < ActionMailer::TestCase
  test "shipped" do
    mail = StanfordMailer.shipped
    assert_equal "Shipped", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
