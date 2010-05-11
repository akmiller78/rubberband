module ElasticSearch
  module Api
    module Index
      def index(document, options={})
        set_default_scope!(options)
        raise "index and type or defaults required" unless options[:index] && options[:type]
        # type
        # index
        # id (optional)
        # op_type (optional)
        # timeout (optional)
        # document (optional)

        execute(:index, options[:index], options[:type], options[:id], document, options)
      end

      def get(id, options={})
        set_default_scope!(options)
        raise "index and type or defaults required" unless options[:index] && options[:type]
        # index
        # type
        # id
        # fields
        
        execute(:get, options[:index], options[:type], id, options)
      end

      #df	 The default field to use when no field prefix is defined within the query.
      #analyzer	 The analyzer name to be used when analyzing the query string.
      #default_operator	 The default operator to be used, can be AND or OR. Defaults to OR.
      #explain	 For each hit, contain an explanation of how to scoring of the hits was computed.
      #fields	 The selective fields of the document to return for each hit (fields must be stored), comma delimited. Defaults to the internal _source field.
      #field	 Same as fields above, but each parameter contains a single field name to load. There can be several field parameters.
      #sort	 Sorting to perform. Can either be in the form of fieldName, or fieldName:reverse (for reverse sorting). The fieldName can either be an actual field within the document, or the special score name to indicate sorting based on scores. There can be several sort parameters (order is important).
      #from	 The starting from index of the hits to return. Defaults to 0.
      #size	 The number of hits to return. Defaults to 10.
      #search_type	 The type of the search operation to perform. Can be dfs_query_then_fetch, dfs_query_and_fetch, query_then_fetch, query_and_fetch. Defaults to query_then_fetch.
      def search(query, options={})
        set_default_scope!(options)

        options = slice_hash(options, :df, :analyzer, :default_operator, :explain, :fields, :field, :sort, :from, :size, :search_type)
        execute(:search, options[:index], options[:type], query, options)
      end

      def delete(id, options={})
        set_default_scope!(options)
        raise "index and type or defaults required" unless options[:index] && options[:type]
        execute(:delete, options[:index], options[:type], id, options)
      end

      private

      def slice_hash(hash, *keys)
        h = {}
        keys.each { |k| h[k] = hash[k] if hash.has_key?(k) }
        h
      end

    end
  end
end
