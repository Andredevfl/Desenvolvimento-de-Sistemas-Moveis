// services/cepService.js
import AsyncStorage from '@react-native-async-storage/async-storage';

export const salvarHistorico = async (endereco) => {
  let historico = await AsyncStorage.getItem('historico');
  historico = historico ? JSON.parse(historico) : [];
  historico.push(endereco);
  await AsyncStorage.setItem('historico', JSON.stringify(historico));
};

export const getHistorico = async () => {
  const historico = await AsyncStorage.getItem('historico');
  return historico ? JSON.parse(historico) : [];
};
