package it.unicam.morpheus.sogniario.mongo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.MongoDatabaseFactory;
import org.springframework.data.mongodb.core.convert.DbRefResolver;
import org.springframework.data.mongodb.core.convert.DefaultDbRefResolver;
import org.springframework.data.mongodb.core.convert.MappingMongoConverter;
import org.springframework.data.mongodb.core.mapping.MongoMappingContext;

/**
 * This class is needed to configure MongoDB to allow dots in field values (this is important to save emails)
 */
@Configuration
public class MongoConfig {

    private final MongoDatabaseFactory mongoFactory;
    private final MongoMappingContext mongoMappingContext;

    @Autowired
    public MongoConfig(MongoDatabaseFactory mongoFactory, MongoMappingContext mongoMappingContext) {
        this.mongoFactory = mongoFactory;
        this.mongoMappingContext = mongoMappingContext;
    }

    @Bean
    public MappingMongoConverter mongoConverter() {
        DbRefResolver dbRefResolver = new DefaultDbRefResolver(mongoFactory);
        MappingMongoConverter mongoConverter = new MappingMongoConverter(dbRefResolver, mongoMappingContext);
        mongoConverter.setMapKeyDotReplacement(".");
        mongoConverter.setMapKeyDotReplacement(":");
        return mongoConverter;
    }
}
