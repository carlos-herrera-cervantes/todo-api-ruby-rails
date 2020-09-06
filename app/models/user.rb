class User
    include Mongoid::Document

    validates :email, presence: true
    validates :name, presence: true
    validates :last_name, presence: true

    field :email, type: String
    field :name, type: String
    field :last_name, type: String

    has_many :todos, dependent: :destroy
end