/**
 * @format
 */

import React from 'react';
import {AppRegistry} from 'react-native';
// import App from './App';
// import {name as appName} from './app.json';

import HomePage from './HomePage';

class RNView extends React.Component {

    constructor(props) {
        super(props);

        console.log(this.props.test);
    }

    render() {
        console.log('进入RN页面的时间 = ', new Date().getTime());
        return (
            <HomePage />
        );
    }
}

// 整体js模块的名称
AppRegistry.registerComponent('RNView', () => RNView);
