module ROM
  module Solr
    module ModifySchema

      INSERT = %w( add-field
                   add-dynamic-field
                   add-field-type
                   add-copy-field )

      UPDATE = %w( replace-field
                   replace-dynamic-field
                   replace-field-type )

      DELETE = %w( delete-field
                   delete-field-type
                   delete-dynamic-field
                   delete-copy-field )

      module Commands; end

      def self.commands
        Commands.constants(false).map { |c| Commands.const_get(c) }
      end

      def self.generate_commands(ops, superclass)
        ops.each do |op|
          class_name = op.split(/-/).map(&:capitalize).join('')
          command = generate_command(op, superclass)
          Commands.const_set(class_name, command)
        end
      end

      def self.generate_command(op, superclass)
        command_name = op.gsub(/-/, '_').to_sym
        body = ->(*args) { relation.send(command_name, *args).response }

        Class.new(superclass) do
          relation :schema_info
          register_as command_name

          define_method :execute, body
        end
      end

      generate_commands(INSERT, ROM::Solr::Commands::Create)
      generate_commands(UPDATE, ROM::Solr::Commands::Update)
      generate_commands(DELETE, ROM::Solr::Commands::Delete)

    end
  end
end
