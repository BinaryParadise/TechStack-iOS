import React from 'react';
import MockData from '../mock/mockdata.json';
import {NativeModules, StyleSheet, Text, View, FlatList, Image, Button} from 'react-native';

const RNBridgeModule = NativeModules.RNBridgeModule;

class HomePage extends React.Component {
  static navigationOptions = ({ navigation }) => {
    return {
      // 相当于对title与params中的'title'做了映射，如需修改，需要传入'title'参数才可生效
      title: navigation.getParam('title', '个人中心'),
      headerLeft: () => (
        <Button 
          onPress = {e => {RNBridgeModule.dismiss()}}
          title = '返回'
          color = '#f00'
        />
      )
    }
  }
  state = {
    statuses: []
  }

  // getDefaultProps() {
  //   console.log('【一次】getDefaultProps');
  // }

  getInitialProps() {
    console.log('【一次】getInitialProps');
  }
  
  shouldComponentUpdate() {
    console.log('【多次】shouldComponentUpdate');
    return true;
  }

  componentDidUpdate() {
    console.log('【多次】componentDidUpdate');
  }

  render() {
    console.log('【大于0次】render');
    const {statuses} = this.state
    return (
      <View style={{flex: 1, backgroundColor: '#F6F6F6'}}>
        <FlatList data={statuses}
        renderItem={this.renderStatus}
        keyExtractor={item => item.id+''}
        onScroll={e => {
          this.contentOffset = e.nativeEvent.contentOffset.y;
        }}
        >
        </FlatList>
      </View>
    );
  }

  componentDidMount() {
    console.log('【一次】componentDidMount');
    fetch("https://api.weibo.com/2/statuses/home_timeline.json?access_token="+this.props.access_token)
    .then((response) => response.json())
    .then((responseJson) => {
      console.log(responseJson);
      if (responseJson.error_code != 0) {
        responseJson = MockData
      }
      this.setState({statuses: responseJson.statuses})
    })
  }

  componentWillUnmount() {
    console.log('【一次】componentWillUnmount');
  }

  renderStatus({item}) {
   return (
     <View style={{flex:1, flexDirection: 'column', backgroundColor: '#F6F6F6'}}>
       <View style={{flex:1, backgroundColor: '#FFFFFF', marginTop: 16}}>
         <View style={{flex:1, flexDirection: 'row', height: 50, alignItems:'center'}}>
           <Image
             source={{uri: item.user.avatar_large}}
             style={styles.thumbnail}
           />
           <Text style={{marginLeft: 8}}>{item.user.screen_name}</Text>
         </View>
         <Text style={{margin:16}}>{item.text}</Text>
       </View>
     </View>
   );
 }

}

const styles = StyleSheet.create({
  thumbnail: {
    marginLeft: 16,
    marginTop: 16,
    width: 40,
    height: 40,
    borderRadius: 20
  }
});

export default HomePage;