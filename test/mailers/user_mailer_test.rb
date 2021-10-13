require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "welcome_email" do
    mail = UserMailer.welcome_email
    assert_equal "user mail",mail.subject
    assert_equal ["to@example.com"],mail.subject
    assert_equal ["from@example.com"],mail.from
    assert_equal "user mail",mail.body.encoded
end
