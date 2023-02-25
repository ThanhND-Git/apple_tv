import '../../models/channel.dart';
import '../const/images.dart';

class DataChannels{
  Set<Channel> listChanels = {
    Channel(name: 'Sports', describe: "Discover the best sport's channels in the world", imageUrl: Images.sport, numberOfChannels: 30),
    Channel(name: 'Movies & Series', describe: "Ready to watch action movies? over 10 channels to watch", imageUrl: Images.spiderManNoWayHome, numberOfChannels: 14),
    Channel(name: 'Fashion', describe: "We love fashion don't we? watch the world's best trends", imageUrl: Images.fashion, numberOfChannels: 8),
    Channel(name: 'Cartoons', describe: "Kids love cartoons, let them watch the most intertaining...", imageUrl: Images.cartoon, numberOfChannels: 5),
  };
}