class MessageController < ApplicationController

	def create
		message = Message.new(username: params[:username], content: params[:content])
		message.save
		poll
	end

	def poll
		@messages = Message.where("id > ?",params[:lastrecieved]).order("id asc").last(10)
		@msglist = @messages.map do |msg|
			{ :username => msg.username, :content => msg.content, :id => msg.id }
		end
		render :json => @msglist.to_json
	end
end
