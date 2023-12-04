import React from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    Dimensions,
    NativeModules,
    TouchableOpacity,
    Image,
    Alert
} from 'react-native';


const { width, height } = Dimensions.get('window')

var Modules = NativeModules.Module

export default class HomePage extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            // 原生层返回的图片路径
            resultPath: ''
        };
    }

    render() {

        const resolveAssetSource = require('react-native/Libraries/Image/resolveAssetSource');
        const sourceImage = require('./imageResoure/origin.png');
        const sourceImagePath = resolveAssetSource(sourceImage);
        const targetImage = require('./imageResoure/mask.png');
        const targetImagePath = resolveAssetSource(targetImage);

        return (
            <View style={styles.backView}>

                <View style={styles.sourceView}>
                    <Image
                        style={{ width: 200, height: 150 }}
                        source={sourceImage}
                    />
                    <Text style={styles.textStyle}>{'源图片'}</Text>
                </View>

                <View style={styles.targetView}>
                    <Image
                        style={{ width: 200, height: 150 }}
                        source={targetImage}
                    />
                    <Text style={styles.textStyle}>{'目标图片'}</Text>
                </View>

                <TouchableOpacity
                    style={styles.button}
                    onPress={() => {
                        // 从原生获取抠图后的图片
                        Modules.getResultImagePath(sourceImagePath, targetImagePath, res => {
                            console.log('获取到的路径 = ', res);
                            this.setState({
                                resultPath: res
                            });
                        });
                    }}
                >
                    <Image
                        style={{ width: 200, height: 150 }}
                        source={{ uri: this.state.resultPath }}
                    />
                    <Text
                        style={[styles.textStyle, {color: 'red'}]}>{"获取原生处理的结果"}</Text>
                </TouchableOpacity>
            </View>

        );
    }
}

const styles = StyleSheet.create({
    backView: {
        flex: 1,
        flexDirection: 'column',
        // justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: 'white'
    },
    sourceView: {
        flexDirection: 'column',
        justifyContent: 'center',
        alignItems: 'center',
        marginTop: 50,
        width: width,
        height: 200,
    },
    targetView: {
        flexDirection: 'column',
        justifyContent: 'center',
        alignItems: 'center',
        width: width,
        height: 200,
    },
    button: {
        marginTop: 100,
        width: width,
        height: 200,
        justifyContent: 'center',
        alignItems: 'center'
    },
    textStyle: {
        fontSize: 20,
        color: 'black'
    }
});