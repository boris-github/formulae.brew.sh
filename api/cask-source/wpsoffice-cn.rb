cask "wpsoffice-cn" do
  arch arm: "arm64", intel: "x64"

  version "4.6.0,7438"

  if Hardware::CPU.intel?
    sha256 "5bef1c67a0b0ed9015d991880e4f843810101da047115e8d8855503786924f0e"
  else
    sha256 "ac79eacd0d389d68de69cce914ce10b9871efd37dbe5864cd8a9eb242ffb3634"
  end

  url "https://package.mac.wpscdn.cn/mac_wps_pkg/#{version.csv.first}/WPS_Office_#{version.csv.first}(#{version.csv.second})_#{arch}.dmg",
      verified: "package.mac.wpscdn.cn/mac_wps_pkg/"
  name "WPS Office"
  desc "All-in-one office service platform in Chinese"
  homepage "https://mac.wps.cn/"

  livecheck do
    url :homepage
    regex(/href=.*?WPS_Office[._-]v?(\d+(?:\.\d+)+)[_(](\d+)[_)]*#{arch}\.dmg/i)
    strategy :page_match do |page|
      page.scan(regex).map { |match| "#{match[0]},#{match[1]}" }
    end
  end

  conflicts_with cask: "wpsoffice"
  depends_on macos: ">= :sierra"

  app "wpsoffice.app"

  zap trash: [
    "~/Library/Application Scripts/com.kingsoft.wpsoffice.mac",
    "~/Library/Application Scripts/com.kingsoft.wpsoffice.mac.FinderSync",
    "~/Library/Application Scripts/com.kingsoft.wpsoffice.mac.recentfiles",
    "~/Library/Application Scripts/YK4WKE5WAM.wpsoffice",
    "~/Library/Containers/com.kingsoft.wpsoffice.mac",
    "~/Library/Containers/com.kingsoft.wpsoffice.mac.FinderSync",
    "~/Library/Containers/com.kingsoft.wpsoffice.mac.recentfiles",
    "~/Library/Containers/YK4WKE5WAM.wpsoffice",
  ]
end
