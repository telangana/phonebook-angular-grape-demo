require_relative '../spec_helper'
require_relative '../../lib/app/api_v1'

describe Phonebook::APIv1 do
  include Rack::Test::Methods

  def app
    Phonebook::APIv1
  end

  describe Phonebook::APIv1 do

    before do
      Phonebook::Model::Contact.repository= Phonebook::Persistence::Memory.new
    end

    describe 'GET /contacts.json' do
      it 'returns an empty array of contacts' do
        get '/contacts.json'
        last_response.status.should == 200
        JSON.parse(last_response.body).should == []
      end
    end

    describe 'POST /contacts' do
      let(:params){ { 'name' => 'Marcel', 'phone' => '1235455667688' } }

      it 'create with valid attributes' do
        post '/contacts', params
        last_response.status.should == 201

        result = JSON.parse(last_response.body).to_h

        result['id'].should be_a Integer
        result['name'].should eql params['name']
        result['phone'].should eql params['phone']
      end
    end

    describe 'PUT /contacts/:id' do
      let(:params){ { 'name' => 'Marcel', 'phone' => '1235455667688' } }
      let(:new_attributes){ { name: 'Marcel Scherf', phone: '491762344545656' } }

      before do
        Phonebook::Model::Contact.repository.add(Phonebook::Model::Contact.new(params))
      end

      it 'update contact info' do
        last_contact = Phonebook::Model::Contact.repository.all.last
        put "/contacts/#{last_contact.id}", new_attributes

        last_response.status.should == 200

        result = JSON.parse(last_response.body).to_h
        result['name'].should eql new_attributes[:name]
        result['phone'].should eql new_attributes[:phone]
      end

    end
  end
end