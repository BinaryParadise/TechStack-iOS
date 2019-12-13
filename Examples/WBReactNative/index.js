import {AppRegistry} from 'react-native';
import { createAppContainer } from 'react-navigation';
import AppNavigator from './App'
import {name as appName} from './package.json';

const AppContainer = createAppContainer(AppNavigator);

AppRegistry.registerComponent(appName, () => AppContainer);
