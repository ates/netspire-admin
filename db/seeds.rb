Admin.create!(:login => 'admin', :password => 'secret')

account1 = Account.create!(:login => 'joel', :password => 'secret',
                           :first_name => 'Joel', :last_name => 'Albers')

account1.deposit(10)
account1.deposit(20)
account1.withdraw(5)


service_opts1 = ["login", "password"]
service_opts2 = ["mac-address"]
service1 = Service.create!(:name => 'iptraffic',
                           :title => 'Internet access via PPP',
                           :options => service_opts1)
service2 = Service.create!(:name => 'voip',
                           :title => 'Voice Over IP',
                           :options => service_opts2)

plan1 = Plan.create!(:name => 'Ultimate', :title => 'Awesome Ultimate',
                     :service => service1.name, :initiation_fee => 10)

attr1 = RadiusAttribute.create!(:name => "Acct-Interim-Interval",
                                :description => "This attribute indicates the number of seconds between each interim update in seconds for this specific session")
attr2 = RadiusAttribute.create!(:name => "Framed-IP-Address",
                                :description => "This attribute indicates the address to be configured for the user")
attr3 = RadiusAttribute.create!(:name => "Service-Type",
                                :description => "This attribute indicates the type of service the user has requested, or the type of service to be provided")
attr4 = RadiusAttribute.create!(:name => "Framed-Protocol",
                                :description => "This attribute indicates the framing to be used for framed access")
attr5 = RadiusAttribute.create!(:name => "Netspire-Framed-Pool",
                                :description => "This attribute indicates the pool of IP addresses that need to use")
attr6 = RadiusAttribute.create!(:name => "Netspire-Upstream-Speed-Limit",
                                :description => "This attribute indicates the UpStream speed limit")
attr7 = RadiusAttribute.create!(:name => "Netspire-Downstream-Speed-Limit",
                                :description => "This attribute indicates the DownStream speed limit")
attr8 = RadiusAttribute.create!(:name => "Netspire-Allowed-NAS",
                                :description => "This attribute indicates the NAS identifier to which the user may connect")

service_link1 = ServiceLink.create!(:account => account1.id,
                                    :service => service1.id,
                                    :plan => plan1.id)
service_link1.radius_replies << RadiusReply.new(:name => attr1.name, :value => 90)
service_link1.radius_replies << RadiusReply.new(:name => attr3.name, :value => 2)
service_link1.radius_replies << RadiusReply.new(:name => attr4.name, :value => 1)
service_link1.service_properties << ServiceProperty.new(:name => service_opts1[0], :value => 'joel')
service_link1.service_properties << ServiceProperty.new(:name => service_opts1[1], :value => 'secret')
service_link1.save!

service_link2 = ServiceLink.create!(:account => account1.id,
                                    :service => service2.id,
                                    :plan => plan1.id)
service_link2.service_properties << ServiceProperty.new(:name => service_opts2[0], :value => '00:02:b3:4c:aa:54')
service_link2.save!
