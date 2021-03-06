#
# Ronin Bruteforcers - A Ruby library for Ronin that provides various
# bruteforcers.
#
# Copyright (c) 2011-2013 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#

require 'ronin/bruteforcers/service_bruteforcer'

require 'net/ftp'

module Ronin
  module Bruteforcers
    #
    # {FTP} attempts to login to an FTP Service, using wordlists of
    # user-names and passwords.
    #
    class FTP < ServiceBruteforcer

      # The port FTP is listening on
      parameter :port, default: 21,
                       description: 'The port that FTP is listening on'

      protected

      #
      # Opens a FTP session.
      #
      # @return [Net::FTP]
      #   The new Net::FTP session.
      #
      def open_session
        ftp = Net::FTP.new
        ftp.connect(self.host,self.port)

        return ftp
      end

      #
      # Closes a FTP session.
      #
      # @param [Net::FTP] ftp
      #   A Net::FTP session.
      #
      def close_session(ftp)
        ftp.close
      end

      #
      # Attemps to authenticate with the FTP credentials.
      #
      # @param [Net::FTP] ftp
      #   The Net::FTP session.
      #
      # @param [String] username
      #   The username to authenticate with.
      #
      # @param [String] password
      #   The password to authenticate with.
      #
      # @return [Boolean]
      #   Specifies whether the credentials were valid.
      #
      def authenticate(ftp,username,password)
        begin
          ftp.login(username,password)
        rescue Net::FTPPermError
          return false
        end

        return true
      end

    end
  end
end
