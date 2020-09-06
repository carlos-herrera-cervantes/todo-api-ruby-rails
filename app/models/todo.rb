class Todo
    include Mongoid::Document

    validates :title, presence: true
    validates :body, presence: true

    field :title, type: String
    field :body, type: String
    field :done, type: Boolean, default: false

    belongs_to :user
end