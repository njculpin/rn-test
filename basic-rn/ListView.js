import React, { useState, useEffect } from 'react';
import { ListCell } from './ListCell'
import { NativeModules, View, Button } from 'react-native';
const { APIBridge } = NativeModules;

function ListView(props){

    let [albums, setAlbums] = useState([])

    async function getResults(){
      APIBridge.download("Jack Johnson").then(result => {
        console.log(result)
      })
    }

    return(
        <View>
          <Button
            onPress={getResults}
            title="Get Apple Music"
            color="#841584"
          />
          {albums.map((album, index) =>
          <ListCell
          history={props.history}
          index={index}
          key={index}
          {...album} />
        )}
        </View>
    )
}

export default ListView;
