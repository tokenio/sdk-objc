platform :ios, '8.0'

target 'TokenSdk' do
  pod '!ProtoCompiler'
  pod '!ProtoCompiler-gRPCPlugin'
  pod "OrderedDictionary"


  target 'TokenSdkTests' do
    inherit! :search_paths
  end
end

#
# Generates Objective-C code for the protos.
#
def fetchProtos()
    # TODO(alexey): Fetch protos from artifactory. They need to be in the public folder!
    # For now we just assume that we have protoc repo at the same level!
    system('cp -r ../lib-proto/common/src/main/proto/* protos/common/')
    system('cp -r ../lib-proto/external/src/main/proto/* protos/external/')
end

#
# Generates Objective-C code for the protos.
#
def generateProtosCmd(path_to_protos, out_dir)
    # Base directory where the .proto files are.
    src = "./protos"

    # Pods directory corresponding to this app's Podfile, relative to the location of this podspec.
    pods_root = 'Pods'

    # Path where Cocoapods downloads protoc and the gRPC plugin.
    protoc_dir = "#{pods_root}/!ProtoCompiler"
    protoc = "#{protoc_dir}/protoc"
    plugin = "#{pods_root}/!ProtoCompiler-gRPCPlugin/grpc_objective_c_plugin"

    result = <<-CMD
       mkdir -p #{out_dir}
       #{protoc} \
           --plugin=protoc-gen-grpc=#{plugin} \
           --objc_out=#{out_dir} \
           --grpc_out=#{out_dir} \
           -I #{src}/common \
           -I #{src}/external \
           -I #{src} \
           -I #{protoc_dir} \
           #{src}/#{path_to_protos}/*.proto
    CMD
    result
end


post_install do |installer|
    # Fetch the protos.
    fetchProtos();

    # Build the command that generates the protos.
    dir = "src/generated"

    gencommand = generateProtosCmd("common", dir) +
        generateProtosCmd("common/google/api", dir) + 
        generateProtosCmd("common/google/protobuf", dir) +
        generateProtosCmd("external/gateway", dir) +
        generateProtosCmd("external/bankapi", dir);

    system(gencommand)
end
