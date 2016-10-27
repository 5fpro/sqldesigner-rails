OmniAuth.config.test_mode = true
OmniAuth.config.add_mock(:facebook,
                         uid: '12345',
                         info: {
                           email: 'omniauth@foobar.com',
                           name: 'foobar'
                         },
                         provider: 'facebook')
OmniAuth.config.add_mock(:google_oauth2,
                         uid: '12345',
                         info: {
                           email: 'omniauth@foobar.com',
                           name: 'foobar'
                         },
                         provider: 'google_oauth2')
OmniAuth.config.add_mock(:github,
                         uid: '12345',
                         info: {
                           email: 'omniauth@foobar.com',
                           name: 'foobar'
                         },
                         provider: 'github')
