# frozen_string_literal: true
def change_build(v, b)
  b['build'] = v
end

def relative_build(ma, mi, r)
  [ma, mi, r].map { |ver| 1 + ver }.join('.')
end

def build_basic_data
  {
    'build': '1.1.2',
    'token': 'TEST_ENV_VALID_TOKEN',
    'content': [
      {
        'name': 'Endpoint 1',
        'object': 'FieldTrip',
        'url': 'http://example.com/microservices_engine/v1/data'
      },
      {
        'name': 'Endpoint 2',
        'object': 'Survey',
        'url': 'http://potatoes.com/microservices_engine/v1/data'
      }
    ]
  }
end

def failing_semantic_builds
  [0, -1]
    .repeated_permutation(3)
    .to_a.map { |bld| relative_build(*bld) } - ['1.1.1']
end

def passing_semantic_builds
  [0, 1]
    .repeated_permutation(3)
    .to_a.map { |bld| relative_build(*bld) }
end
