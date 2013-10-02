class Link

	include DataMapper::Resource

	has n, :tags, :through => Resource
	belongs_to :user

	property :id, 			Serial
	property :title, 		String, length: 1..50, :message=> "Keep your title short. Max 50 chars."
	property :url, 			String
	property :created_at, 	DateTime

end