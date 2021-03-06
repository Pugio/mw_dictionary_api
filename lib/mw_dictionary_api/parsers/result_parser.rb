# encoding: UTF-8

module MWDictionaryAPI
  module Parsers
    class ResultParser
      include Parsable

      rule :entries do |data, opts|
        data.css("entry").inject([]) do |entries, xml_entry|
          parser = Parsers::EntryParser.new(api_type: opts[:api_type], response_format: opts[:response_format])
          entries << parser.parse(xml_entry)
          entries
        end
      end

      rule :suggestions do |data, opts|
        data.css("suggestion").inject([]) do |suggestions, suggestion_xml|
          suggestions << suggestion_xml.content
        end
      end
    end
  end
end