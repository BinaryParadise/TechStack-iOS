import React from 'react';
import MockData from './mockdata.json'
import {AppRegistry, StyleSheet, Text, View, FlatList, Image} from 'react-native';

class WBReactNative extends React.Component {
  state = {
    statuses: []
  }
  componentDidMount() {
    console.log(this.props)
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

  render() {
    const {statuses} = this.state
    return (
      <View style={{flex: 1, backgroundColor: '#F6F6F6'}}>
        <View styple={{flexDirection: 'row',height:88, width:'100%', backgroundColor: '#FF00FF'}}>
          <View style={{marginTop:44, height:44,justifyContent: 'center',alignItems: 'center'}}>
            <Text>微博</Text>
          </View>
        </View>
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

// 整体js模块的名称
AppRegistry.registerComponent('WBReactNative', () => WBReactNative);
