TOKEN_PROTOS_VER = "1.2.18"
FANK_PROTOS_VER = "1.2.2"
RPC_PROTOS_VER = "1.0.124"

platform :ios, '9.0'
inhibit_all_warnings!

target 'TokenSdk' do
  pod '!ProtoCompiler'
  pod '!ProtoCompiler-gRPCPlugin'
  pod "OrderedDictionary"
  pod 'Unirest', '~>1.1.4'
  # A workaround for issue https://github.com/firebase/firebase-ios-sdk/issues/2665
  pod 'Protobuf', :inhibit_warnings => true

  target 'TokenSdkTests' do
    inherit! :search_paths
    pod 'Protobuf', :inhibit_warnings => true
  end
end


require 'open-uri'

#
# Fetches specified proto files from the artifact repository.
#
def fetch_protos()
    def download(path, name, type, version)
        file = "#{name}-#{type}-#{version}.jar"
        puts("Downloading #{file} ...")

        m2path = ENV["HOME"] + "/.m2/repository/#{path}/#{name}-#{type}/#{version}/#{file}"
        if File.file?(m2path) then
            FileUtils.cp(m2path, file)
        else
            url = "https://token.jfrog.io/token/libs-release/#{path}/#{name}-#{type}/#{version}/#{file}"
            open(file, 'wb') do |file|
                file << open(url).read
            end
        end
        file
    end

    system("rm protos/common/*.proto")
    system("rm -rf protos/external")

    file = download("io/token/proto", "tokenio-proto", "external", TOKEN_PROTOS_VER)
    system("unzip -d protos/external -o #{file} 'gateway/*.proto'")
    system("rm -f #{file}");

    file = download("io/token/proto", "tokenio-proto", "common", TOKEN_PROTOS_VER)
    system("unzip -d protos/common -o #{file} '*.proto'")
    system("unzip -d protos/common -o #{file} 'google/api/*.proto'")
    system("rm -f #{file}");

    file = download("io/token/fank", "tokenio-fank", "proto", FANK_PROTOS_VER)
    system("unzip -d protos -o #{file} '*.proto'")
    system("rm -f #{file}");

    file = download("io/token/rpc", "tokenio-rpc", "proto", RPC_PROTOS_VER)
    system("unzip -d protos -o #{file} '*.proto'")
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
    system("rm -rf #{dir}");

    gencommand = 
        generate_protos_cmd("common", dir) +
        generate_protos_cmd("common/provider", dir) +
        generate_protos_cmd("common/google/api", dir) + 
        generate_protos_cmd("common/google/protobuf", dir) +
        generate_protos_cmd("external/gateway", dir) +
        generate_protos_cmd("fank", dir) +
        generate_protos_cmd("extensions", dir) ;
    
    system(gencommand)
    
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
            config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.12'
        end
    end
end
