TOKEN_PROTOS_VER = "1.0.129"
platform :ios, '8.0'


target 'TokenSdk' do
  pod '!ProtoCompiler'
  pod '!ProtoCompiler-gRPCPlugin'
  pod "OrderedDictionary"


  target 'TokenSdkTests' do
    inherit! :search_paths
  end
end


require 'open-uri'

#
# Fetches specified proto files from the artifact repository.
#
def fetch_protos()
    def download(version, type)
        file = "tokenio-proto-#{type}-#{version}.jar"
        puts("Downloading #{file} ...")

        url = "https://token.artifactoryonline.com/token/public-libs-release-local/io/token/proto/tokenio-proto-#{type}/#{version}/#{file}"
        open(file, 'wb') do |file|
            file << open(url).read
        end
        file
    end

    file = download(TOKEN_PROTOS_VER, :external)
    system("unzip -d protos/external -o #{file} 'bankapi/banklink.proto'")
    system("unzip -d protos/external -o #{file} 'bankapi/fank.proto'")
    system("unzip -d protos/external -o #{file} 'gateway/*.proto'")
    system("rm -f #{file}");

    file = download(TOKEN_PROTOS_VER, :common)
    system("unzip -d protos/common -o #{file} '*.proto'")
    system("unzip -d protos/common -o #{file} 'google/api/*.proto'")
    system("rm -f #{file}");
end

#
# Generates Objective-C code for the protos.
#
def generate_protos_cmd(path_to_protos, out_dir)
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
    fetch_protos();

    # Build the command that generates the protos.
    dir = "src/generated"

    gencommand = generate_protos_cmd("common", dir) +
        generate_protos_cmd("common/google/api", dir) + 
        generate_protos_cmd("common/google/protobuf", dir) +
        generate_protos_cmd("external/gateway", dir) +
        generate_protos_cmd("external/bankapi", dir);

    system(gencommand)
end
