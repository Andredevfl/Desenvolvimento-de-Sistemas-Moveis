// screens/HomeScreen.js
import React, { useState } from 'react';
import { View, Text, TextInput, Button, StyleSheet } from 'react-native';
import axios from 'axios';
import { useNavigation } from '@react-navigation/native';

const HomeScreen = () => {
  const [cep, setCep] = useState('');
  const [loading, setLoading] = useState(false);
  const [endereco, setEndereco] = useState(null);
  const [erro, setErro] = useState('');
  const navigation = useNavigation();

  const consultarCEP = () => {
    setLoading(true);
    axios
      .get(`https://viacep.com.br/ws/${cep}/json/`)
      .then((response) => {
        setEndereco(response.data);
        setLoading(false);
        setErro('');
      })
      .catch((err) => {
        setErro('CEP não encontrado');
        setLoading(false);
      });
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Consulta de CEP</Text>
      <TextInput
        style={styles.input}
        placeholder="Digite o CEP"
        value={cep}
        onChangeText={setCep}
      />
      <Button title="Consultar" onPress={consultarCEP} />
      {loading && <Text>Carregando...</Text>}
      {erro && <Text style={styles.error}>{erro}</Text>}
      {endereco && (
        <View style={styles.endereco}>
          <Text>{endereco.logradouro}</Text>
          <Text>{endereco.bairro}</Text>
          <Text>{endereco.localidade} - {endereco.uf}</Text>
        </View>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: { flex: 1, justifyContent: 'center', alignItems: 'center', padding: 20 },
  title: { fontSize: 24, fontWeight: 'bold' },
  input: { borderWidth: 1, width: '100%', marginBottom: 20, padding: 10 },
  error: { color: 'red' },
  endereco: { marginTop: 20 },
});

export default HomeScreen;
