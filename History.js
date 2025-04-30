// screens/HistoryScreen.js
import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, FlatList } from 'react-native';
import { getHistorico } from '../services/cepService';

const HistoryScreen = () => {
  const [historico, setHistorico] = useState([]);

  useEffect(() => {
    const loadHistorico = async () => {
      const data = await getHistorico();
      setHistorico(data);
    };

    loadHistorico();
  }, []);

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Histórico de Consultas</Text>
      <FlatList
        data={historico}
        renderItem={({ item }) => (
          <View style={styles.item}>
            <Text>{item.logradouro}, {item.bairro}</Text>
            <Text>{item.localidade} - {item.uf}</Text>
          </View>
        )}
        keyExtractor={(item, index) => index.toString()}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: { flex: 1, padding: 20 },
  title: { fontSize: 24, fontWeight: 'bold', marginBottom: 20 },
  item: { padding: 10, borderBottomWidth: 1 },
});

export default HistoryScreen;
