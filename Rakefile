task :default do
  Dir['manifests/*.pp'].each do |manifest|
    sh "puppet parser validate #{manifest}"
  end
  sh "puppet-lint manifests/*.pp"
end

task :template do
  sh "s3cmd put --acl-public templates/neo4j-server.properties.erb s3://cf-templates.neo4j.org"
end
