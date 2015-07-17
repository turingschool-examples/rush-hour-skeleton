# A sample Guardfile
# More info at https://github.com/guard/guard#readme

# guard 'rspec' do
#   watch(%r{^spec/.+_spec\.rb$})
#   watch(%r{^app/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
#   watch('spec/spec_helper.rb')  { "spec" }
# end

guard 'rake' do
  watch(%r{^test/.+_test\.rb$})
  watch(%r{^app/(.+)\.rb$})     { |m| "test/#{m[1]}_test.rb" }
  watch('test/test_helper.rb')  { "test" }
end
