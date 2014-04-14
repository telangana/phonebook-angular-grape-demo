require_relative '../phonebook'

module Phonebook
  Model::Contact.repository = ::Framework::Persistence::Redis.new(Model::Contact, 'phonebook_development')

  class APIv1 < ::Grape::API
    version 'v1', using: :header, vendor: 'phonebook'

    content_type :csv, 'application/csv'
    format :csv
    formatter :csv, Phonebook::Formatters::CSV

    content_type :json, 'application/json'
    format :json

    default_format :json

    resource :contacts do
      desc 'GET all contacts'
      get do
        @contacts = Model::Contact.repository.all
        present @contacts, with: Phonebook::Entities::Contact
      end

      desc 'POST create new contact'
      # this does not work with rack::test
      params do
        requires :name, type: String, desc: "Contact's name"
        requires :phone, type: String, desc: "Contact's phone number"
      end
      post do

        Model::Contact.repository.add(Model::Contact.new({ name: params[:name], phone: params[:phone] }))
      end

      desc 'Update contact'
      params do
        requires :id, type: Integer, desc: 'ID of contact, that should be updated'
        requires :name, type: String, desc: 'New name for contact'
        requires :phone, type: String, desc: 'New phone for contact'
      end
      put ':id' do
        Model::Contact.repository.update(Phonebook::Model::Contact.new({ id: params[:id], name: params[:name], phone: params[:phone] }))
      end

      desc 'Delete contact'
      params do
        requires :id, type: Integer, desc: 'ID of contact, that should be deleted'
      end
      delete ':id' do
        Model::Contact.repository.delete(params[:id])
      end

    end

    before do
      if params['format'] == 'csv'
        header['Content-Disposition'] = "attachment; filename=#{env['api.endpoint']}.csv}"
      end
    end
  end

end