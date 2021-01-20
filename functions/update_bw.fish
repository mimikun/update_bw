function update_bw --description 'Update bitwarden-cli'
    echo "Update bitwarden-cli?"

    if read_confirm
        set OLD_VERSION (bw --version)
        set VERSION (curl --silent https://api.github.com/repos/bitwarden/cli/releases/latest | jq .tag_name -r | sed -e 's/v//g')
        set DESTINATION /usr/local/bin/bw
        if test $OLD_VERSION != $VERSION
            echo "Update found!"
            curl -L https://github.com/bitwarden/cli/releases/download/v$VERSION/bw-linux-$VERSION.zip -o /tmp/bw.latest.zip
            sleep 5
            set CURRENTDIR (pwd)
            cd /tmp && unzip bw.latest.zip
            sleep 5
            cd $CURRENTDIR
            sudo cp /tmp/bw $DESTINATION
            sudo rm -f /tmp/bw*
            sudo chmod 755 $DESTINATION
        else
            echo "No update required."
        end
    end
end
