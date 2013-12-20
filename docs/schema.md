### User
screen_name
authenticated default: false
api_user_id_str

### TweetTip (like a followings table)
content
api_tweet_id_str
recipient_id user
sender_id user
transaction_id

### Transaction
satoshis
tx_hash
tweet_tip_id
address_id

### Address
encrypted_private_key
public_key
user_id


### Migrations
rails g model User screen_name:string authenticated:boolean api_user_id_str:string

rails g model TweetTip content:string api_tweet_id_str:string recipient_id:integer sender_id:integer transaction_id:integer

rails g model Transaction satoshis:integer tx_hash:string tweet_tip_id:integer address_id:integer

rails g model Address encrypted_private_key:string public_key:string user_id:integer
