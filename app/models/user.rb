class User < ActiveRecord::Base
    has_one :admin, dependent: :destroy
    has_one :applicant, dependent: :destroy
    has_many :applications, through: :applicant
    has_one :judge. dependent: :destroy
    has_one :recommender, dependent: :destroy

    has_secure_password
    validates :email, uniqueness: true

    class << self
        def verifier_for(purpose)
            @verifiers ||= {}
            @verifiers.fetch(purpose) do |p|
                @verifiers[p] = Rails.application.message_verifier("#{self.name}-#{p.to_s}")
            end
        end

        def generate_token_for(purpose, id, address)
            verifier = verifier_for(purpose)
            verifier.generate([id, Time.now, address])
        end

        def extract_token_id(tok, purpose)
            id, timestamp, address = verifier_for(purpose).verify(tok)
            id
        end
        
        def extract_token_address(tok, purpose)
            id, timestamp, address = verifier_for(purpose).verify(tok)
            address
        end

        def verify_token_for(tok, purpose, oid, oaddress, timelimit=1.day.ago)
            id, timestamp, address = verifier_for(purpose).verify(tok)
            if timelimit 
                if timestamp > timelimit
                    id == oid && oaddress == address
                else
                    false
                end
            else
                oid == id && oaddress == address
            end
        end
    end

	def display
		self.name
	end

    def admin?
        self.admin || false
    end

    def promote_admin
        if admin?
            self.admin
        else
            self.create_admin
        end
    end

    def applicant?
        self.applicant || false
    end

    def promote_applicant
        if applicant?
            self.applicant
        else
            self.create_applicant
        end
    end

    def judge?
        self.judge || false
    end

    def promote_judge
        if judge?
            self.judge
        else
            self.create_judge
        end
    end

    def recommender?
        self.recommender || false
    end

    def promote_recommender
        if recommender?
            self.recommender
        else
            self.create_recommender status: 0
        end
    end

    def roles
        list = []
        list << applicant if applicant
        list << judge if judge
        list << recommender if recommender
        list << admin if admin
        list
    end
end
