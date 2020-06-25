import React from 'react';
import { View, Text } from 'react-native';

export function ListCell(props){
    return(
        <View>
            <Text>{props.name}</Text>
        </View>
    )
}
