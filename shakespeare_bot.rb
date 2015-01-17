require 'redditkit'
require './shakespearean_insult'

class RunBot
  def initialize
    si = ShakespeareanInsult.new
    run_bot(si)
    sleep(2)
  end

  def sign_in
    # set username and password
    username ||= ENV["bot_username"]
    password ||= ENV["bot_password"]
    return client = RedditKit::Client.new(username, password)
  end

  def run_bot(shakespeare)
    # process messages
    while true
      # sign in client
      begin
        client = sign_in
        sleep(2)
        process_messages(client, shakespeare)
        sleep(2)
      rescue RedditKit::ServiceUnavailable
        puts "oops!"
      end
    end
  end

  def process_messages(client, shakespeare)
    messages = client.messages(options = {category: 'mentions'})
    # iterate through messages
    unless messages.nil?
      messages.each do |message|
        # if message is new reply to parent comment
        if message.attributes[:new]
          p message.attributes[:context]
          sleep(2)
          parent = client.comment(message.attributes[:parent_id])
          sleep(2)
          author = parent.attributes[:author]
          client.submit_comment(message.attributes[:parent_id], "/u/#{author}, #{shakespeare.insult}!")
          sleep(30)
          #mark message as read
          client.mark_as_read(message.attributes[:name])
          sleep(2)
        end    
      end
    end
  end
end

RunBot.new

