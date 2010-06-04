module ElasticSearch
  module Api
    module Admin
      module Index
        PSEUDO_INDICES = [:all]

        def index_status(*args)
          options = args.last.is_a?(Hash) ? args.pop : {}
          indices = args.empty? ? [(default_index || :all)] : args.flatten
          indices.collect! { |i| PSEUDO_INDICES.include?(i) ? "_#{i}" : i }
          execute(:index_status, indices, options)
        end

        # options: number_of_shards, number_of_replicas
        def create_index(index, create_options={}, options={})
          unless create_options[:index]
            create_options = { :index => create_options }
          end
          execute(:create_index, index, create_options, options)
        end

        def delete_index(index, options={})
          execute(:delete_index, index, options)
        end

        # list of indices, or :all
        # options: refresh
        # default: default_index if defined, otherwise :all
        def flush(*args)
          options = args.last.is_a?(Hash) ? args.pop : {}
          indices = args.empty? ? [(default_index || :all)] : args.flatten
          indices.collect! { |i| PSEUDO_INDICES.include?(i) ? "_#{i}" : i }
          execute(:flush, indices, options)
        end

        # list of indices, or :all
        # no options
        # default: default_index if defined, otherwise all
        def refresh(*args)
          options = args.last.is_a?(Hash) ? args.pop : {}
          indices = args.empty? ? [(default_index || :all)] : args.flatten
          indices.collect! { |i| PSEUDO_INDICES.include?(i) ? "_#{i}" : i }
          execute(:refresh, indices, options)
        end
        
        # list of indices, or :all
        # no options
        # default: default_index if defined, otherwise all
        def snapshot(*args)
          options = args.last.is_a?(Hash) ? args.pop : {}
          indices = args.empty? ? [(default_index || :all)] : args.flatten
          indices.collect! { |i| PSEUDO_INDICES.include?(i) ? "_#{i}" : i }
          execute(:snapshot, indices, options)
        end

        # list of indices, or :all
        # options: max_num_segments, only_expunge_deletes, refresh, flush
        # default: default_index if defined, otherwise all
        def optimize(*args)
          options = args.last.is_a?(Hash) ? args.pop : {}
          indices = args.empty? ? [(default_index || :all)] : args.flatten
          indices.collect! { |i| PSEUDO_INDICES.include?(i) ? "_#{i}" : i }
          execute(:optimize, indices, options)
        end
      end
    end
  end
end
