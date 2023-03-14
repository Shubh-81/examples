export const idlFactory = ({ IDL }) => {
  const Name = IDL.Text;
  const Phone = IDL.Text;
  const Entry = IDL.Record({ 'desc' : IDL.Text, 'phone' : Phone });
  return IDL.Service({
    'deleteEntry' : IDL.Func([IDL.Text], [IDL.Text], []),
    'insert' : IDL.Func([Name, Entry], [IDL.Text], []),
    'lookup' : IDL.Func([IDL.Text], [IDL.Opt(Entry)], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
