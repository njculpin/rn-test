'use strict';

import React, { Component } from 'react';
import {
  StyleSheet,
  View,
  SafeAreaView,
} from 'react-native';
import ListView from './ListView';

export default class App extends Component {
  render() {
    return (
        <SafeAreaView>
          <View>
            <ListView/>
          </View>
        </SafeAreaView>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});
