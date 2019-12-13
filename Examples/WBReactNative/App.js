import React from 'react';
import { View, Text } from 'react-native';
import { createStackNavigator } from 'react-navigation-stack';
import HomeScreen from './page/home'

const AppNavigator = createStackNavigator({
  Home: {
    screen: HomeScreen,
  },
});

export default AppNavigator;