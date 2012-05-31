# OmniAuth Stripe Platform Strategy &nbsp;

Stripe Platform OAuth2 Strategy for OmniAuth 1.0.


## Installing

Add to your `Gemfile`:

```ruby
gem 'omniauth-stripeplatform'
```

Then `bundle install`.

## Usage

`OmniAuth::Strategies::StripePlatform` is simply a Rack middleware. Read the OmniAuth 1.0 docs for detailed instructions: https://github.com/intridea/omniauth.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :stripeplatform, ENV['STRIPE_CLIENT_ID'], ENV['SECRET_API_SECRET']
end
```
The CLIENT_ID can be found by logging into your stripe.com account, Your Account => Account Settings => Applications => Manage your own applications.




## Configuring


```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['STRIPE_CLIENT_ID'], ENV['STRIPE_API_SECRET'],
           :scope => 'read_write'
end
```


## Supported Rubies

Actively tested with the following Ruby versions:

- MRI 1.9.3


## License

Copyright (c) 2012 by Anthony Joseph

Permission is hereby granted, free of charge, to do whatever the hell you want with it. 

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
